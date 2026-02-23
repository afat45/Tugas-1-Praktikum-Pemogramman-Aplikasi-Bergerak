import 'package:flutter/material.dart';

// --- DATA MODEL ---
// Merepresentasikan data pendaftaran kunjungan
class Registration {
  String id;
  String clientName;
  String phoneNumber;
  String address;
  String visitDate;

  Registration({
    required this.id,
    required this.clientName,
    required this.phoneNumber,
    required this.address,
    required this.visitDate,
  });
}

void main() {
  runApp(const BarongsaiApp());
}

// --- MAIN WIDGET ---
class BarongsaiApp extends StatelessWidget {
  const BarongsaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barongsai Visit Register',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Tema Warna Merah & Emas (Khas Imlek/Barongsai)
        primaryColor: const Color(0xFFD32F2F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD32F2F),
          secondary: const Color(0xFFFFD700), // Emas
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD32F2F),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFD32F2F),
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// --- HOME SCREEN (READ & DELETE) ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List untuk menyimpan data (Simulasi Database Lokal)
  final List<Registration> _registrations = [];

  // Navigasi ke FormScreen untuk Tambah Data
  void _navigateToAdd() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormScreen()),
    );

    if (result != null && result is Registration) {
      setState(() {
        _registrations.add(result);
      });
      _showSnackBar("Jadwal berhasil ditambahkan!");
    }
  }

  // Navigasi ke FormScreen untuk Edit Data (UPDATE)
  void _navigateToEdit(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormScreen(
          existingData: _registrations[index],
        ),
      ),
    );

    if (result != null && result is Registration) {
      setState(() {
        _registrations[index] = result;
      });
      _showSnackBar("Jadwal berhasil diperbarui!");
    }
  }

  // Fungsi Hapus Data (DELETE)
  void _deleteData(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Hapus Jadwal?"),
        content: const Text("Data yang dihapus tidak dapat dikembalikan."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _registrations.removeAt(index);
              });
              Navigator.pop(ctx);
              _showSnackBar("Data berhasil dihapus.");
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kunjungan Barongsai'),
        leading: const Icon(Icons.celebration), // Ikon tema
      ),
      body: _registrations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_busy, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text(
                    "Belum ada jadwal kunjungan.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _registrations.length,
              itemBuilder: (context, index) {
                final item = _registrations[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        item.clientName[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      item.clientName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(item.visitDate),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                                child: Text(item.address,
                                    overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tombol Edit
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _navigateToEdit(index),
                        ),
                        // Tombol Hapus
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteData(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAdd,
        label: const Text("Tambah Jadwal"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

// --- FORM SCREEN (CREATE & UPDATE) ---
class FormScreen extends StatefulWidget {
  final Registration? existingData;

  const FormScreen({super.key, this.existingData});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk TextFields
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data lama jika mode Edit
    _nameController = TextEditingController(text: widget.existingData?.clientName ?? '');
    _phoneController = TextEditingController(text: widget.existingData?.phoneNumber ?? '');
    _addressController = TextEditingController(text: widget.existingData?.address ?? '');
    _dateController = TextEditingController(text: widget.existingData?.visitDate ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _saveData() {
    if (_formKey.currentState!.validate()) {
      // Membuat object Registration baru
      final registration = Registration(
        id: widget.existingData?.id ?? DateTime.now().toString(),
        clientName: _nameController.text,
        phoneNumber: _phoneController.text,
        address: _addressController.text,
        visitDate: _dateController.text,
      );

      // Mengirim data kembali ke halaman sebelumnya
      Navigator.pop(context, registration);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingData != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Jadwal" : "Daftar Baru"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TextField 1: Nama Pemesan
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nama Pemesan",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Nama tidak boleh kosong" : null,
              ),
              const SizedBox(height: 16),

              // TextField 2: Nomor Telepon
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Nomor WhatsApp/HP",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Nomor HP wajib diisi" : null,
              ),
              const SizedBox(height: 16),

              // TextField 3: Tanggal Kunjungan
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: "Tanggal Kunjungan (e.g. 10 Feb 2024)",
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                  helperText: "Format bebas",
                ),
                validator: (value) =>
                    value!.isEmpty ? "Tanggal wajib diisi" : null,
              ),
              const SizedBox(height: 16),

              // TextField 4: Alamat Lengkap
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Alamat Lokasi Pertunjukan",
                  prefixIcon: Icon(Icons.home),
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) =>
                    value!.isEmpty ? "Alamat wajib diisi" : null,
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: _saveData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: const Icon(Icons.save),
                label: Text(
                  isEdit ? "PERBARUI DATA" : "SIMPAN DATA",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}